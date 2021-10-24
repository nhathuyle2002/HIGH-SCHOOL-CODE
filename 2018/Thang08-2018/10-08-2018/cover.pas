type    segment =record l,r,id:longint;end;

const   ginp='cover.inp';
        gout='cover.out';
        maxn=100010;

var     n,p,q,top:longint;
        d:array[0..maxn] of longint;
        a:array[0..maxn] of segment;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:segment;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].r<t.r) or ((a[i].r=t.r) and (a[i].l>t.l)) do inc(i);
                while (a[j].r>t.r) or ((a[j].r=t.r) and (a[j].l<t.l)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i,nn:longint;
        b:array[0..maxn] of segment;
        dd:array[0..maxn] of boolean;
begin
        readln(n,p,q);
        fillchar(dd,sizeof(dd),true);
        for i:=1 to n do
        begin
                readln(a[i].l,a[i].r);
                if (a[i].r<p) or (a[i].l>q) then dd[i]:=false;
                if a[i].l<p then a[i].l:=p;
                if a[i].r>q then a[i].r:=q;
                a[i].id:=i;
        end;
        nn:=n;n:=0;b:=a;
        for i:=1 to nn do
                if dd[i] then
                begin
                        inc(n);
                        a[n]:=b[i];
                end;
        sort(1,n);
end;

procedure process;
var     i:longint;
begin
        if (p=q) and (n>0) then
        begin
                writeln(1);
                write(a[1].id);
                exit;
        end;
        top:=0;d[0]:=0;a[0].r:=p;
        for i:=1 to n do
        begin
                if a[i].l>a[d[top]].r then continue;
                while (top>0) and (a[i].l<=a[d[top-1]].r) do dec(top);
                inc(top);d[top]:=i;
        end;
        if (a[d[top]].r<q) or (top=0) then write(-1) else
        begin
                writeln(top);
                for i:=1 to top do write(a[d[i]].id,' ');
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
