const   ginp='bonus.inp';
        gout='bonus.out';
        a:array[1..4] of longint= (2,3,5,7);

var     gi,go:text;
        n,res:qword;

procedure dequy(i,tt:longint;p:qword);
var     j:longint;
begin
        if tt>4 then exit;
        for j:=i+1 to 4 do
        begin
                p:=p*a[j];
                if tt mod 2=1 then res:=res+n div p
                else res:=res-n div p;
                dequy(j,tt+1,p);
                p:=p div a[j];
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        dequy(0,1,1);
        write(go,n-res);
        close(gi);close(go);
end.
