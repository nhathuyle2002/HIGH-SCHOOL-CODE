Const   ginp='palind.inp';
        gout='palind.out';

Var     n,mid:longint;
        a,b:ansistring;

Function Cmp(x,y:ansistring):boolean;
Var     i:longint;
begin
        for i:=1 to length(x) do
                if x[i]<y[i] then exit(false) else
                if x[i]>y[i] then exit(true);
        exit(true);
end;

Procedure Enter;
Var     i:longint;
Begin
        read(a); n:=length(a);
        mid:=n shr 1+n and 1;
        b:='';
        for i:=1 to mid do b:=b+a[i];
        for i:=mid+1 to n do b:=b+a[n-i+1];
End;

Procedure Process;
Var     i,j:longint;
Begin
        if cmp(b,a) then
        begin
                write(b); exit;
        end;
        for i:=mid to n do
                if b[i]<'9' then
                begin
                        b[i]:=chr(ord(b[i])+1);
                        b[n-i+1]:=b[i];
                        for j:=i-1 downto mid do
                        begin
                                b[j]:='0'; b[n-j+1]:='0';
                        end;
                        break;
                end;
        write(b);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
