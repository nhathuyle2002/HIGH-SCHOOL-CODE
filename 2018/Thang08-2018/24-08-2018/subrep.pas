const   ginp='subrep.inp';
        gout='subrep.out';

var     m,n,res:longint;
        a,b:ansistring;

procedure enter;
begin
        readln(b);n:=length(b);
        read(a);m:=length(a);
end;

procedure process;
var     i,j:longint;
begin
        res:=0;j:=1;
        for i:=1 to m do
        begin
                if a[i]=b[j] then inc(j);
                if j=n+1 then
                begin
                        inc(res);
                        j:=j-n;
                end;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
