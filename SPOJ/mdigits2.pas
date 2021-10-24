const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:string;
        ans,pt:longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,pt);
        str(pt,n);
end;

procedure process;
var     i,m:longint;
        s:ansistring;
        tm:string;
begin
        m:=length(n);s:='';
        for i:=1 to pt do
        begin
                str(i,tm);
                s:=s+tm;
        end;
        for i:=1 to length(s)-m+1 do
                if copy(s,i,m)=n then
                begin
                        ans:=i;
                        exit;
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
