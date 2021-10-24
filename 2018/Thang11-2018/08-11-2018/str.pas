Uses    Math;

Const   ginp='str.inp';
        gout='str.out';
        maxn=1000010;

Var     a:ansistring;
        f:array[0..maxn,0..1] of longint;

Procedure Process;
Var     i:longint;
Begin
        read(a);
        for i:=1 to length(a) do
        begin
                f[i,0]:=min(f[i-1,0],f[i-1,1]+1);
                f[i,1]:=min(f[i-1,1],f[i-1,0]+1);
                if a[i]='A' then inc(f[i,1]) else inc(f[i,0]);
        end;
        write(min(f[length(a),0],f[length(a),1]+1));
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.


