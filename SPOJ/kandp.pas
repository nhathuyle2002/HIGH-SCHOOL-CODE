const   ginp='ss.inp';
        gout='ss.out';
        minx:=-10000;

var     gi,go:text;
        ok:boolean;
        mx,my,tx,ty,cs:longint;
        f:array[minx..1010] of longint;

procedure input;
begin
        readln(gi,mx,my);
        readln(gi,tx,ty);
        read(gi,cs);
end;

procedure process;
var     kc,d:longint;
begin
        if cs=1 then dec(tx);
        if abs(mx-tx+my-ty) mod 2=0 then
        begin
                ok:=false;
                exit;
        end;
        ok:=true;
        d:=abs(my-ty);
        if d=1 then
        begin
                f[mx]:=3;
                f[mx-1]:=2;f[mx+1]:=2;
                f[mx-2]:=1;f[mx+2]:=1;
                kc:=3;
        end else
        if d=2 then
        begin
                f[mx]:=2;
                f[mx-1]:=1;f[mx+1]:=1;
                f[mx-2]:=4;f[mx+2]:=4;
                kc:=3;
        end else
        if d mod 2=0 then
        begin
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        close(gi);close(go);
end.
