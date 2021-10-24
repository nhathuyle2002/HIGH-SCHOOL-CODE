Const   ginp='icecream.inp';
        gout='icecream.out';
        maxn=301;
        maxg=10001;
        base=trunc(1e9)+9;

Type    save= record m1,m2,m4:longint; end;

Var     n,mmax,m10,m20,m40:longint;
        top,top2:longint;
        q,q2:array[0..maxn*maxg] of save;
        d,d2:array[0..maxg,0..maxn] of int64;
        res:int64;

Procedure Enter;
Begin
        readln(n,mmax);
        read(m10,m20,m40);
End;

Procedure Push(m1,m2,m4:longint; x:int64);
Begin
        if d[m2,m4]=-1 then
        begin
                inc(top);
                q[top].m1:=m1; q[top].m2:=m2; q[top].m4:=m4;
                d[m2,m4]:=0;
        end;
        d[m2,m4]:=(d[m2,m4]+x) mod base;
End;

Procedure Process;
Var     k,i:longint;
Begin
        for k:=0 to n do
                for i:=0 to mmax do
                begin
                        d2[i,k]:=-1;
                        d[i,k]:=-1;
                end;
        top:=0; top2:=0;
        push(m10,m20,0,1);
        for k:=1 to n do
        begin
                for i:=1 to top2 do
                        d2[q2[i].m2,q2[i].m4]:=-1;
                top2:=top;
                for i:=1 to top do
                begin
                        d2[q[i].m2,q[i].m4]:=d[q[i].m2,q[i].m4];
                        d[q[i].m2,q[i].m4]:=-1;
                        q2[i]:=q[i];
                end;
                top:=0;
                for i:=1 to top2 do
                with q2[i] do
                begin
                        if (m1<mmax) then push(m1+1,m2,m4,d2[m2,m4]);
                        if (m2<mmax) and (m1>=1) then push(m1-1,m2+1,m4,d2[m2,m4]);
                        if (m4+m40<mmax) then
                        begin
                                if (m2>=1) and (m1>=1) then push(m1-1,m2-1,m4+1,d2[m2,m4]) else
                                if (m1>=3) then push(m1-3,m2,m4+1,d2[m2,m4]);
                        end;
                end;
        end;
        res:=0;
        for i:=1 to top do
                res:=(res+d[q[i].m2,q[i].m4]) mod base;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
