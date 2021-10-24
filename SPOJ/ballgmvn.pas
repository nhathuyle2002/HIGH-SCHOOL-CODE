const   ginp='ss.inp';
        gout='ss.out';

type    point=record x,y:longint;end;
        save=record gt:real;vt:longint;end;

var     gi,go:text;
        n:longint;
        a,b:array[0..1001] of point;
        c:array[0..1001] of save;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i].x,a[i].y);
        for i:=1 to n do readln(gi,b[i].x,b[i].y);
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:save;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while (c[i].gt<t.gt) or ((c[i].gt=t.gt) and (c[i].vt<t.vt)) do inc(i);
                while (c[j].gt>t.gt) or ((c[j].gt=t.gt) and (c[j].vt>t.vt)) do dec(j);
                if i<=j then
                begin
                        tm:=c[i];c[i]:=c[j];c[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,j,tm1,tm2:longint;
begin
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        c[j].vt:=j;
                        tm1:=a[i].x-b[j].x;
                        tm2:=a[i].y-b[j].y;
                        if tm2=0 then c[j].gt:=-1 else c[j].gt:=tm1/tm2;
                end;
                sort(1,n);
                for j:=2 to n do
                        if c[j].gt=c[j-1].gt then
                        begin
                                write(go,i,' ',c[j-1].vt+n,' ',c[j].vt+n);
                                exit;
                        end;
                for j:=1 to n do
                begin
                        c[j].vt:=j;
                        tm1:=b[i].x-a[j].x;
                        tm2:=b[i].y-a[j].y;
                        if tm2=0 then c[j].gt:=-1 else c[j].gt:=tm1/tm2;
                end;
                sort(1,n);
                for j:=2 to n do
                        if c[j].gt=c[j-1].gt then
                        begin
                                write(go,c[j-1].vt,' ',c[j].vt,' ',i+n);
                                exit;
                        end;
        end;
        write(go,-1);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
