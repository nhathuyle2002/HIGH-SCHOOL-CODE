const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:int64;

function process:boolean;
var     tm:int64;
        k,i:longint;
begin
        k:=trunc(sqrt(n));
        for i:=k downto 0 do
        begin
                tm:=n-int64(i)*i;
                if trunc(sqrt(tm))=sqrt(tm) then exit(true);
        end;
        exit(false);
end;

procedure main;
var     i,t:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for i:=1 to t do
        begin
                readln(gi,n);
                if process then writeln(go,'Yes') else writeln(go,'No');
        end;
        close(gi);close(go);
end;

begin
        main;
end.