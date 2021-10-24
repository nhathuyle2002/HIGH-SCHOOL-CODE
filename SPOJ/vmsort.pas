const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        res,k,n:longint;
        a:array[0..1001] of string[20];

procedure main;
var     i,j,p:longint;
        ok:boolean;
        s:string[20];
begin
        res:=0;
        readln(gi,k);
        for j:=1 to k do
        begin
                readln(gi,n);
                for i:=1 to n do
                begin
                        readln(gi,s);
                        ok:=true;
                        for p:=1 to res do
                                if a[p]=s then ok:=false;
                        if ok then
                        begin
                                inc(res);
                                a[res]:=s;
                        end;
                end;
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        write(go,res);
        close(gi);close(go);
end.
