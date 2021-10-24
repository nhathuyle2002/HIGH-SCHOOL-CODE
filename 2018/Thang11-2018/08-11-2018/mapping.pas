Const   ginp='mapping.inp';
        gout='mapping.out';

Var     x,y,z:int64;

Procedure Process;
Var     l,r,mid:int64;
Begin
        readln(x,y);
        writeln((x+y-2)*(x+y-1) div 2+y);
        read(z);
        l:=1; r:=2000000000;
        while l<r do
        begin
                mid:=(l+r) div 2;
                if mid*(mid+1) div 2<z then l:=mid+1 else r:=mid;
        end;
        dec(l);
        y:=z-l*(l+1) div 2;
        x:=l+2-y;
        write(x,' ',y);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
