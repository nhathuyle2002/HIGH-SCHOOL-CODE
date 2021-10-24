Const   ginp='palind.inp';
        gout='palind.out';
        maxn=1000010;
        base=211;
        modul=trunc(1e9)+13;

Var     n:longint;
        a,b:ansistring;
        ha,hb,pow:array[0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        read(a); n:=length(a);
        b:='';
        for i:=n downto 1 do b:=b+a[i];
End;

Procedure Process;
Var     i,p:longint;
Begin
        pow[0]:=1;
        for i:=1 to n do
        begin
                ha[i]:=(ha[i-1]*base+ord(a[i])) mod modul;
                hb[i]:=(hb[i-1]*base+ord(b[i])) mod modul;
                pow[i]:=(pow[i-1]*base) mod modul;
        end;
        p:=n;
        for i:=n-1 downto 1 do
                if hb[n-i+1]=(ha[n]-ha[i-1]*pow[n-i+1]+modul*modul) mod modul then p:=i;
        write(a);
        for i:=p-1 downto 1 do write(a[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
