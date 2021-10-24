Const   ginp='decode.inp';
        gout='decode.out';
        maxn=100010;

Var     n,q:longint;
        a,b:string[30];
        ms:array['A'..'Z'] of char;
        s:ansistring;
        pl,pr:array[0..maxn] of longint;

Procedure Enter;
Var     i,j:longint;
        tmp:char;
Begin
        readln(a); b:=a;
        for i:=1 to length(a) do
                for j:=i+1 to length(a) do
                        if b[i]>b[j] then
                        begin
                                tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
                        end;
        for i:=1 to length(a) do ms[b[i]]:=a[i];
        readln(s);
        readln(q);
        for i:=1 to q do readln(pl[i],pr[i]);
End;

Procedure Process;
Var     i:longint;
        s2:ansistring;
Begin
        for q:=q downto 1 do
        begin
                s2:='';
                for i:=pl[q] to pr[q] do s2:=s2+ms[s[i]];
                s[pl[q]]:=s2[pr[q]-pl[q]+1];
                for i:=pl[q]+1 to pr[q] do s[i]:=s2[i-pl[q]];
        end;
        write(s);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
