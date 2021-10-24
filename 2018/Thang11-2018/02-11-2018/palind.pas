Const   ginp='palind.inp';
        gout='palind.out';
        base=211;
        modu=trunc(1e9)+13;

Var     n,rr:longint;
        a,b:ansistring;
        ha,hb:int64;
        pow:array[0..1000010] of int64;

Procedure Enter;
Var     i:longint;
Begin
        read(a);
        n:=length(a);
        b:='';
        pow[0]:=1;
        for i:=1 to n do
        begin
                b:=b+a[n-i+1];
                pow[i]:=pow[i-1]*base mod modu;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        write(a);
        rr:=0;
        ha:=0; hb:=0;
        for i:=1 to n do
        begin
                ha:=(ha+pow[i-1]*ord(a[n-i+1])) mod modu;
                hb:=(hb*pow[1]+ord(b[i])) mod modu;
                if ha=hb then rr:=i;
        end;
        for i:=rr+1 to n do write(b[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
