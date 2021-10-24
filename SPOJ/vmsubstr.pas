const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        f:array[1..52,1..52] of longint;
        a:array[1..52] of longint;

function gt(x:char):longint;
begin
        if ('A'<=x) and (x<='Z') then exit(ord(x)-64);
        exit(ord(x)-70);
end;

procedure input;
var     i,l:longint;
        x:char;
        s:ansistring;
begin
        readln(gi,l);
        readln(gi,s);
        inc(a[gt(s[1])]);
        for i:=2 to l do
        begin
                inc(a[gt(s[i])]);
                inc(f[gt(s[i]),gt(s[i-1])]);
        end;
end;

procedure process;
var     i,q,n,t:longint;
        ans,j:longint;
        s:string;
begin
        readln(gi,q);
        for t:=1 to q do
        begin
                readln(gi,s);n:=length(s);
                ans:=0;
                for i:=1 to n do
                begin
                        ans:=ans+a[gt(s[i])];
                        for j:=1 to n do ans:=ans-f[gt(s[i]),gt(s[j])];
                end;
                writeln(go,ans);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
