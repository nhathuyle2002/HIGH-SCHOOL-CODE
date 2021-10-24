const   ginp='empty.inp';
        gout='empty.out';
        maxn=trunc(3e6);

var     n:longint;
        a:array[0..maxn] of longint;
        d:array[0..maxn] of boolean;

procedure enter;
var     i,t,q,x,y,aa,bb:longint;
begin
        readln(n,q);
        for t:=1 to q do
        begin
                readln(x,y,aa,bb);
                if x=0 then continue;
                for i:=1 to y do
                        inc(a[(int64(aa)*i+bb) mod n],x);
        end;
        for i:=0 to n-1 do d[i]:=true;
end;

procedure process;
var     i,k,v:longint;
begin
        v:=0;
        for i:=0 to n-1 do
        begin
                if v<i then v:=i;
                for k:=1 to a[i] do
                begin
                        while not d[v mod n] do inc(v);
                        d[v mod n]:=false;
                end;
        end;
        for i:=0 to n-1 do
                if d[i] then break;
        write(i);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
