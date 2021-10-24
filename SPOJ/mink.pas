const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,k,l,r,t:longint;
        a,d:array[0..1000000] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
end;

function empty:boolean;
begin
        if l>r then exit(false) else exit(true);
end;

procedure push(i:longint);
begin
        while (empty) and (a[d[r]]>a[i]) do dec(r);
        inc(r);d[r]:=i;
end;

procedure pop(i:longint);
begin
        while (empty) and (d[l]<i) do inc(l);
end;

procedure deque;
var     i:longint;
begin
        readln(gi,n,k);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
        l:=0;r:=0;d[0]:=0;
        for i:=1 to n do
        begin
                push(i);
                if i>=k then
                begin
                        pop(i-k+1);
                        write(go,a[d[l]],' ');
                end;
        end;
        writeln(go);
end;

procedure output;
var     i:longint;
begin
        for i:=1 to t do deque;
        close(gi);close(go);
end;

begin
        input;
        output;
end.