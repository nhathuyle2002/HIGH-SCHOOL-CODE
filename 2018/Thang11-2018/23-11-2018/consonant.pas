Const   ginp='consonant.inp';
        gout='consonant.out';
        dd:set of char = ['a','e','i','o','u','w','y'];
        n = 19;

Var     la,res:longint;
        a:ansistring;
        f:array[0..1 shl n+1] of longint;
        d:array[0..n+1,0..n+1] of longint;
        ms:array['a'..'z'] of longint;

Procedure Init;
Var     i:char;
        cou:longint;
Begin
        cou:=0;
        for i:='a' to 'z' do
                if i in dd then ms[i]:=0 else
                begin
                        inc(cou);
                        ms[i]:=cou;
                end;
End;

Procedure Enter;
Var     i:longint;
Begin
        read(a); la:=length(a);
        fillchar(d,sizeof(d),0);
        for i:=1 to la-1 do
                if (ms[a[i]]<>0) and (ms[a[i+1]]<>0) and (a[i]<>a[i+1]) then
                begin
                        inc(d[ms[a[i]],ms[a[i+1]]]);
                        inc(d[ms[a[i+1]],ms[a[i]]]);
                end;
End;

Procedure Process;
Var     x,p,i:longint;
        c:array[0..n+1] of boolean;

        Function Getb(x,i:longint):longint;
        Begin
                getb:=x shr (i-1) and 1;
        End;

        Function Setb(x,i,t:longint):longint;
        Begin
                if t=1 then setb:=x or (1 shl (i-1))
                else setb:=x and (not (1 shl (i-1)));
        End;

Begin
        f[0]:=0; res:=0;
        for x:=1 to 1 shl n-1 do
        begin
                for i:=1 to n do
                        if getb(x,i)=1 then
                        begin
                                p:=i;
                                break;
                        end;
                f[x]:=f[setb(x,i,0)];
                for i:=1 to n do
                        if getb(x,i)=1 then f[x]:=f[x]-d[p,i] else f[x]:=f[x]+d[p,i];
                if f[x]>f[res] then res:=x;
        end;
        fillchar(c,sizeof(c),true);
        for i:=1 to n do
                if getb(res,i)=1 then c[i]:=false;
        for i:=1 to la do
                if c[ms[a[i]]] then write(a[i]) else write(upcase(a[i]));
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Init;
        Enter;
        Process;
        Close(input); Close(output);
End.
