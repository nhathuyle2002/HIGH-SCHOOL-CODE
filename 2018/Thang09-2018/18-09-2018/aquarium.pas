Const   ginp='aquarium.inp';
        gout='aquarium.out';
        maxh=1000010;

Var     n,high:longint;
        dd:array[0..maxh] of longint;
        f,dl,dr,ddr:array[0..maxh] of extended;

Procedure Enter;
Var     i,tmp,l,r,ll:longint;
        tt:extended;
Begin
        readln(n,high);
        read(ll);
        for i:=1 to n do
        begin
                read(r); l:=ll; ll:=r;
                if l>r then
                begin
                        tmp:=l; l:=r; r:=tmp;
                end;
                if l<r then
                begin
                        tt:=1/(2*(r-l));
                        dl[l]:=dl[l]+tt; dr[r]:=dr[r]+tt;
                        ddr[r]:=ddr[r]+(r-l)/2-tt*(r-l-1)*(r-l-1);
                end;
                dd[r]:=dd[r]+1;
        end;
        readln;
End;

Procedure Process;
Var     h,cou:longint;
        sum,ssum:extended;
Begin
        cou:=0; sum:=0; ssum:=0;
        for h:=1 to high do
        begin
                ssum:=ssum+2*sum;
                sum:=sum+dl[h-1]; ssum:=ssum+dl[h-1];
                f[h]:=f[h-1]+ssum+cou;
                sum:=sum-dr[h]; ssum:=ssum-ddr[h];
                cou:=cou+dd[h];
        end;
End;

Procedure Result;
Var     i,q,x:longint;
Begin
        readln(q);
        for i:=1 to q do
        begin
                readln(x);
                writeln(f[x]:0:4);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Result;
        Close(input); Close(output);
End.
