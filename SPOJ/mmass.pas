const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        ans,r:longint;
        s:string;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,s);
        s:='('+s;s:=s+')1';
end;

function gt(x:char):longint;
begin
        if x='C' then exit(12);
        if x='H' then exit(1);
        if x='O' then exit(16);
        if (x='(') or (x=')') then exit(-1);
        exit(0);
end;

function sum(i:longint):longint;
begin
        sum:=0;
        while i<=length(s) do
        begin
                r:=i;
                if s[i]='(' then sum:=sum+sum(i+1)
                else if s[i]=')' then
                begin
                        r:=i;
                        if gt(s[i+1])=0 then
                        begin
                                sum:=sum*(ord(s[i+1])-48);
                                inc(r);
                        end;
                        exit;
                end else
                if gt(s[i])=0 then sum:=sum+gt(s[i-1])*(ord(s[i])-49)
                else sum:=sum+gt(s[i]);
                i:=r+1;
        end;
end;

procedure output;
begin
        write(go,sum(1));
        close(gi);close(go);
end;

begin
        input;
        output;
end.
