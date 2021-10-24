const   ginp='zigzag.inp';
        gout='zigzag.out';
        oo=trunc(1e14);

var     gi,go:text;
        n:longint;
        a,b:array[0..1000100] of int64;
        ma,mb,res:int64;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        res:=-oo;
        for i:=1 to n do
        begin
                read(gi,a[i]);
                res:=max(res,a[i]);
        end;
        readln(gi);
        for i:=1 to n do
        begin
                read(gi,b[i]);
                res:=max(res,b[i]);
        end;
end;

procedure process;
var     i:longint;
        tm:int64;
begin
        ma:=0;mb:=0;
        for i:=1 to n do
        begin
                tm:=mb+a[i];
                mb:=max(mb,ma+b[i]);
                ma:=max(ma,tm);
        end;
        write(go,max(ma,mb));
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        if res<=0 then write(go,res) else process;
        close(gi);close(go);
end.
