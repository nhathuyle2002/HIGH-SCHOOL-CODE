const   ginp='ss.inp';
        gout='ss.out';

type    mang=record gt,cs:longint;end;

var     gi,go:text;
        n:longint;
        a:array[0..100101] of mang;
        d:array[0..100101] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,a[i].gt);
                a[i].cs:=i;
        end;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:mang;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].gt<t.gt) or ((a[i].gt=t.gt) and (a[i].cs<t.cs)) do inc(i);
                while (a[j].gt>t.gt) or ((a[j].gt=t.gt) and (a[j].cs>t.cs)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure output;
var     i,ans:longint;
begin
        ans:=0;
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
                if d[a[i].cs] then
                begin
                        inc(ans);
                        d[a[i].cs]:=false;
                        d[a[i].cs-1]:=false;
                        d[a[i].cs+1]:=false;
                end;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        output;
end.

