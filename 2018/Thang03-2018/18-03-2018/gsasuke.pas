const   ginp='gsasuke.inp';
        gout='gsasuke.out';

var     gi,go:text;
        n:longint;
        f,h:array[0..100001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,h[i]);
end;

function kc(i,j:longint):int64;
begin
        if i=j-1 then exit(abs(h[j]-h[i]))
        else exit(2*abs(h[j]-h[i]));
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i:longint;
begin
        f[1]:=h[1];
        f[2]:=h[1]+kc(1,2);
        for i:=3 to n do
                f[i]:=min(f[i-1]+kc(i-1,i),f[i-2]+kc(i-2,i))
end;

procedure output;
begin
        write(go,f[n]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
