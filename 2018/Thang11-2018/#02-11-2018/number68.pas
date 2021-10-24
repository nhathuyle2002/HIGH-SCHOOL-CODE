Const   ginp='number68.inp';
        gout='number68.out';

Var     n:longint;
        a,res:ansistring;

Procedure Enter;
Begin
        read(a);
        n:=length(a);
End;

Procedure Process;
Var     i,ii,i0:longint;
Begin
        res:='';
        for i:=1 to n do
                if a[i]>'8' then
                begin
                        for ii:=1 to i-1 do res:=res+a[ii];
                        for ii:=i to n do res:=res+'8';
                        break;
                end else
                if a[i]='8' then continue else
                if a[i]>'6' then
                begin
                        for ii:=1 to i-1 do res:=res+a[ii];
                        res:=res+'6';
                        for ii:=i+1 to n do res:=res+'8';
                        break;
                end else
                if a[i]='6' then continue else
                if a[i]<'6' then
                begin
                        for i0:=i-1 downto 0 do
                                if (i0>0) and (a[i0]='8') then break;
                        if i0=0 then
                                for ii:=2 to n do res:=res+'8' else
                        begin
                                for ii:=1 to i0-1 do res:=res+a[ii];
                                res:=res+'6';
                                for ii:=i0+1 to n do res:=res+'8';
                        end;
                        break;
                end;
        if res='' then
                for i:=1 to n do res:=res+a[i];
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
