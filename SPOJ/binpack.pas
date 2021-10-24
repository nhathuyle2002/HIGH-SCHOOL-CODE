Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e8);

Var     n,l,res:longint;
        a:array[0..1000001] of longint;
        f,l2:array[0..10001,0..5001] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(l,n);
        for i:=1 to n do read(a[i]);
End;

Procedure Process1;
        Procedure Try(i,k,l1,l2:longint);
        Begin
                if k>=res then exit;
                if i>n then
                begin
                        res:=k;
                        exit;
                end;
                if l1+a[i]>l then try(i+1,k+1,a[i],l2) else try(i+1,k,l1+a[i],l2);
                if l2+a[i]>l then try(i+1,k+1,l1,a[i]) else try(i+1,k,l1,l2+a[i]);
        End;
Begin
        res:=oo;
        try(1,0,l,l);
        writeln(res);
End;

Procedure Process2;
Var     i,l1,l2,tmp:longint;
Begin
        res:=0;
        l1:=l; l2:=l;
        for i:=1 to n do
        begin
                if (l1+a[i]) mod 2=0 then
                begin
                        if l1+a[i]>l then
                        begin
                                inc(res);
                                l1:=a[i];
                        end
                        else l1:=l1+a[i];
                end else
                if (l2+a[i]) mod 2=0 then
                begin
                        if l2+a[i]>l then
                        begin
                                inc(res);
                                l2:=a[i];
                        end
                        else l2:=l2+a[i];
                end else
                begin
                        if l1+a[i]>l then
                        begin
                                inc(res);
                                l1:=a[i];
                        end else l1:=l1+a[i];
                end;
                if l1>l2 then
                begin
                        tmp:=l1; l1:=l2; l2:=tmp;
                end;
        end;
        if l1+l2<=l then dec(res);
        writeln(res);
End;

Procedure Process3;
Var     i,l1:longint;
Begin
        for i:=0 to n do
                for l1:=0 to l do f[i,l1]:=oo;
        f[0,l]:=0; l2[0,l]:=l;
        for i:=0 to n-1 do
                for l1:=0 to l do
                if f[i,l1]<oo then
                begin
                        if l1+a[i+1]>l then
                        begin
                                if (f[i,l1]+1<f[i+1,a[i+1]]) or ((f[i,l1]+1=f[i+1,a[i+1]]) and (l2[i,l1]<l2[i+1,a[i+1]])) then
                                begin
                                        f[i+1,a[i+1]]:=f[i,l1]+1;
                                        l2[i+1,a[i+1]]:=l2[i,l1];
                                end;
                        end else
                        begin
                                if (f[i,l1]<f[i+1,l1+a[i+1]]) or ((f[i,l1]=f[i+1,l1+a[i+1]]) and (l2[i,l1]<l2[i+1,l1+a[i+1]])) then
                                begin
                                        f[i+1,l1+a[i+1]]:=f[i,l1];
                                        l2[i+1,l1+a[i+1]]:=l2[i,l1];
                                end;
                        end;
                        if l2[i,l1]+a[i+1]>l then
                        begin
                                if (f[i,l1]+1<f[i+1,l1]) or ((f[i,l1]+1=f[i+1,l1]) and (a[i+1]<l2[i+1,l1])) then
                                begin
                                        f[i+1,l1]:=f[i,l1]+1;
                                        l2[i+1,l1]:=a[i+1];
                                end;
                        end else
                        begin
                                if (f[i,l1]<f[i+1,l1]) or ((f[i,l1]=f[i+1,l1]) and (l2[i,l1]+a[i+1]<l2[i+1,l1])) then
                                begin
                                        f[i+1,l1]:=f[i,l1];
                                        l2[i+1,l1]:=l2[i,l1]+a[i+1];
                                end;
                        end;
                end;
        res:=oo;
        for l1:=0 to l do res:=min(res,f[n,l1]);
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        if n<=20 then Process1 else
        if n>10000 then Process2 else
        Process3;
        Close(input); Close(output);
End.
