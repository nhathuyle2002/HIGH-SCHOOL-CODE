const   ginp='kagain.inp';
        gout='kagain.out';

var     gi,go:text;
        n,t:longint;
        l,r,a:array[0..30001] of longint;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
end;

procedure doc;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
end;

procedure lam;
var     i,tm:longint;
begin
        l[1]:=0;
        for i:=2 to n do
        begin
                tm:=i-1;
                while a[i]<=a[tm] do tm:=l[tm];
                l[i]:=tm;
        end;
        r[n]:=n+1;
        for i:=n-1 downto 1 do
        begin
                tm:=i+1;
                while a[i]<=a[tm] do tm:=r[tm];
                r[i]:=tm;
        end;
end;

procedure xuat;
var     i,d,c,ans,tmp:longint;
begin
        ans:=0;d:=0;c:=0;
        for i:=1 to n do
        begin
                tmp:=(r[i]-l[i]-1)*a[i];
                if (tmp>ans) or ((tmp=ans) and (l[i]+1<d)) then
                begin
                        d:=l[i]+1;
                        c:=r[i]-1;
                        ans:=tmp;
                end;
        end;
        writeln(go,ans,' ',d,' ',c);
end;

procedure output;
var     i:longint;
begin
        for i:=1 to t do
        begin
                doc;
                lam;
                xuat;
        end;
        close(gi);close(go);
end;

begin
        input;
        output;
end.