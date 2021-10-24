Const   ginp='hexa.inp';
        gout='hexa.out';
        ms:array[0..15] of char= ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');

Var     x:int64;
        res:string[20];

Procedure Process;
Begin
        read(x); res:='';
        while x>0 do
        begin
                res:=ms[x mod 16]+res;
                x:=x div 16;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
