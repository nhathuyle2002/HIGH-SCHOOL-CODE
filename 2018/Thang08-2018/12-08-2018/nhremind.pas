const   ginp='nhremind.inp';
        gout='nhremind.out';
        base=311;
        kk=trunc(1e9)+13;

var     la,nb,td1,td2,t3,vr:longint;
        a,b:ansistring;
        ha,hb,pow,d1,d2:array[0..1000001] of int64;
        lb,v,vd1:array[0..1000001] of longint;

procedure enter;
var     i:longint;
        c:ansistring;
begin
        readln(nb);
        for i:=1 to nb do
        begin
                readln(c);
                lb[i]:=lb[i-1]+length(c);
                b:=b+c;
        end;
        read(a);la:=length(a);
        pow[0]:=1;
        for i:=1 to la do pow[i]:=(pow[i-1]*base) mod kk;
        for i:=1 to la do ha[i]:=(ha[i-1]*base+ord(a[i])) mod kk;
        for i:=1 to lb[nb] do hb[i]:=(hb[i-1]*base+ord(b[i])) mod kk;
end;

procedure sort1(l,r:longint); inline;
var     i,j,tt:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d1[random(r-l+1)+l];
        repeat
                while d1[i]<t do inc(i);
                while d1[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d1[i];d1[i]:=d1[j];d1[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort1(l,j);sort1(i,r);
end;

procedure sort3(l,r:longint); inline;
var     i,j,tt:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d1[random(r-l+1)+l];
        repeat
                while d1[i]<t do inc(i);
                while d1[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d1[i];d1[i]:=d1[j];d1[j]:=tm;
                        tt:=vd1[i];vd1[i]:=vd1[j];vd1[j]:=tt;
                        inc(i);dec(j);
                end;
        until i>j;
        sort3(l,j);sort3(i,r);
end;

procedure sort2(l,r:longint); inline;
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d2[random(r-l+1)+l];
        repeat
                while d2[i]<t do inc(i);
                while d2[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d2[i];d2[i]:=d2[j];d2[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j);sort2(i,r);
end;

function check(lc:longint):boolean; inline;
var     i,k:longint;
begin
        td1:=0;
        for i:=lc to la do
        begin
                inc(td1);
                d1[td1]:=(ha[i]-ha[i-lc]*pow[lc]+kk*kk) mod kk;
        end;
        sort1(1,td1);
        td2:=0;
        for k:=1 to nb do
                for i:=lb[k-1]+lc to lb[k] do
                begin
                        inc(td2);
                        d2[td2]:=(hb[i]-hb[i-lc]*pow[lc]+kk*kk) mod kk;
                end;
        sort2(1,td2);
        k:=1;d2[td2+1]:=kk+1;
        for i:=1 to td1 do
        begin
                while (k<=td2) and (d2[k]<d1[i]) do inc(k);
                if d2[k]<>d1[i] then exit(true);
        end;
        exit(false);
end;

procedure result(lc:longint);
var     i,k,l,r,m:longint;
        h1,h2:int64;
begin
        td1:=0;
        for i:=lc to la do
        begin
                inc(td1);
                d1[td1]:=(ha[i]-ha[i-lc]*pow[lc]+kk*kk) mod kk;
                vd1[td1]:=i-lc+1;
        end;
        sort3(1,td1);
        td2:=0;
        for k:=1 to nb do
                for i:=lb[k-1]+lc to lb[k] do
                begin
                        inc(td2);
                        d2[td2]:=(hb[i]-hb[i-lc]*pow[lc]+kk*kk) mod kk;
                end;
        sort2(1,td2);
        k:=1;d2[td2+1]:=kk+1;
        t3:=0;
        for i:=1 to td1 do
        begin
                while (k<=td2) and (d2[k]<d1[i]) do inc(k);
                if d2[k]<>d1[i] then
                begin
                        inc(t3);
                        v[t3]:=vd1[i];
                end;
        end;
        vr:=v[1];
        for i:=2 to t3 do
        begin
                l:=1;r:=lc;
                while l<r do
                begin
                        m:=(l+r) shr 1;
                        h1:=(ha[vr+m-1]-ha[vr-1]*pow[m]+kk*kk) mod kk;
                        h2:=(ha[v[i]+m-1]-ha[vr-1]*pow[m]+kk*kk) mod kk;
                        if h1=h2 then l:=m+1 else r:=m;
                end;
                if a[vr+l-1]>a[v[i]+l-1] then vr:=v[i];
        end;
        for i:=vr to vr+lc-1 do write(a[i]);
end;

procedure process;
var     l,r,m:longint;
begin
        l:=1;r:=la+1;
        while l<r do
        begin
                m:=(l+r) shr 1;
                if check(m) then r:=m else l:=m+1;
        end;
        if l<=la then result(l);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

