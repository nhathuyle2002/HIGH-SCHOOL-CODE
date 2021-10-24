Const   ginp='primetuple.inp';
        gout='primetuple.out';
        mn=100010;

Var     n,k,nt,top,ll,rr,md:longint;
        f:array[0..13,0..13] of int64;
        res:int64;
        a,d:array[0..mn] of longint;

Procedure Init;
Var     i,j:longint;
        d:array[0..mn] of boolean;
Begin
        f[0,0]:=1;
        for i:=1 to 13 do
        begin
                f[i,0]:=1; f[i,i]:=1;
                for j:=1 to i-1 do
                        f[i,j]:=f[i-1,j]+f[i-1,j-1];
        end;
        fillchar(d,sizeof(d),true);
        nt:=0;
        for i:=2 to mn do
                if d[i] then
                begin
                        inc(nt); a[nt]:=i;
                        for j:=i to mn div i do d[i*j]:=false;
                end;
End;

Function Check(x:longint):boolean;
Var     i:longint;
Begin
        for i:=1 to nt do
                if a[i]>sqrt(x) then exit(true) else
                if x mod a[i]=0 then exit(false);
End;

Procedure Enter;
Var     i:longint;
Begin
        read(ll,rr,k,md);
        top:=0;
        for i:=ll to rr do
                if check(i) then
                begin
                        inc(top);
                        d[top]:=i;
                end;
End;

Procedure Process;
Var     l,r:longint;
Begin
        if k=1 then
        begin
                write(top); exit;
        end;
        res:=0; r:=1;
        for l:=1 to top do
        begin
                while (r<=top) and (d[r]-d[l]<md) do inc(r);
                if r>top then break;
                if d[r]-d[l]=md then res:=res+f[r-l-1,k-2];
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Init;
        Enter;
        Process;
        Close(input); Close(output);
End.
