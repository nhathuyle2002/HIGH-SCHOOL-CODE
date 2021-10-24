CONST
    tfi = 'ss.inp';
    tfo = 'ss.out';
VAR
    fi,fo           : text;

Function pro(l,r: longint): longint;
    Var
        len,res: longint;
    Begin
        len:=r-l+1;
        l:=l mod 16;
        r:=r mod 16;
        If l=0 then l:=16;
        If r=0 then r:=16;
        res:=len div 16;
        If len>=32 then exit(res*16)
        else
            If len>=9 then exit(2)
            else
                If ((l=9)) or ((l>9) and (r0 do
            begin
                read(fi,l,r);
                writeln(fo,pro(l,r));
                dec(test);
            end;
    End;

BEGIN
    assign(fi,tfi); reset(fi);
    assign(fo,tfo); rewrite(fo);
        process;
    close(fi); close(fo);
END.
