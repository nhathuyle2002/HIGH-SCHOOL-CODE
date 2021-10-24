const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,r,re:longint;
        a,f1,f2,d:array[0..100001] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

function cnp(x:longint):longint;
var     da,cu,mi:longint;
begin
        da:=1;cu:=r;
        while da<>cu do
        begin
                mi:=(da+cu) shr 1;
                if a[d[mi]]>=x then cu:=mi else da:=mi+1;
        end;
        exit(da);
end;

procedure process;
var     i,tm:longint;
begin
        d[0]:=0;
        r:=1;f1[1]:=1;d[1]:=1;
        for i:=2 to n do
        begin
                if a[i]>a[d[r]] then
                begin
                        inc(r);
                        d[r]:=i;
                        f1[i]:=r;
                end else
                begin
                        tm:=cnp(a[i]);
                        d[tm]:=a[i];
                        f1[i]:=tm;
                end;
        end;
        r:=1;f2[1]:=a[n];d[1]:=n;
        for i:=n-1 downto 1 do
        begin
                if a[i]>a[d[r]] then
                begin
                        inc(r);
                        d[r]:=i;
                        f2[i]:=r;
                end else
                begin
                        tm:=cnp(a[i]);
                        d[tm]:=a[i];
                        f2[i]:=tm;
                end;
        end;
        re:=0;
        for i:=1 to n do
        begin
                if f1[i]<f2[i] then tm:=f1[i] else tm:=f2[i];
                if re<tm then re:=tm;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,2*re-1);
        close(gi);close(go);
end.
