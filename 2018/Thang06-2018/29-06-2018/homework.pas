const   ginp='homework.inp';
        gout='homework.out';
        oo=trunc(1e18);

var     n,nr,st:longint;
        a,b:array[1..4] of int64;
        d,e:string[4];
        res:array[0..300000] of int64;

procedure enter;
var     i,nn:longint;
        tm:int64;
        s:ansistring;
begin
        readln(s);
        n:=0;d:='';
        i:=0;nn:=length(s);
        s:=s+'@';
        repeat
                tm:=0;inc(i);
                while (i<=nn) and (s[i] in ['0'..'9']) do
                begin
                        tm:=tm*10+ord(s[i])-48;
                        inc(i);
                end;
                inc(n);a[n]:=tm;d:=d+s[i];
        until i>=nn;
end;

function ccl(x,y:int64;dd:char):int64;
begin
        if (x=-oo) or (y=-oo) then exit(-oo);
        if dd='+' then exit(x+y);
        if dd='-' then exit(x-y);
        if dd='*' then exit(x*y);
        if dd='/' then
        begin
                if y<>0 then exit(x div y);
                exit(-oo);
        end;
        if y<>0 then exit(x mod y);
        exit(-oo);
end;

function tinhgt(l,r:longint):int64;
var     i,nn:longint;
        c:array[1..4] of int64;
        f:string[4];

procedure tinh;
var     i,v:longint;
begin
        v:=1;
        for i:=2 to nn-1 do
                if ((f[v]='+') or (f[v]='-')) and (f[i]<>'+') and (f[i]<>'-') then v:=i;
        c[v]:=ccl(c[v],c[v+1],f[v]);
        delete(f,v,1);
        for i:=v+1 to nn-1 do c[i]:=c[i+1];
        dec(nn);
end;

begin
        nn:=r-l+1;
        for i:=1 to nn do c[i]:=a[i+l-1];
        f:=copy(d,l,nn);
        while nn>1 do tinh;
        exit(c[1]);
end;

procedure process1;
begin
        b:=a;e:=d;
        inc(nr);res[nr]:=tinhgt(1,4);
        a:=b;d:=e;
        a[2]:=ccl(a[1],a[2],d[1]);
        inc(nr);res[nr]:=tinhgt(2,4);
        a:=b;d:=e;
        a[3]:=ccl(a[3],a[4],d[3]);
        inc(nr);res[nr]:=tinhgt(1,3);
        a:=b;d:=e;
        a[2]:=ccl(a[1],a[2],d[1]);a[3]:=ccl(a[3],a[4],d[3]);
        inc(nr);res[nr]:=ccl(a[2],a[3],d[2]);
        a:=b;d:=e;
        a[2]:=ccl(a[2],a[3],d[2]);delete(d,2,1);a[3]:=a[4];
        inc(nr);res[nr]:=tinhgt(1,3);
        a:=b;d:=e;
        a[3]:=tinhgt(1,3);
        inc(nr);res[nr]:=ccl(a[3],a[4],d[3]);
        a:=b;d:=e;
        a[2]:=tinhgt(2,4);
        inc(nr);res[nr]:=ccl(a[1],a[2],d[1]);
end;

procedure process2;
begin
        b:=a;e:=d;
        inc(nr);res[nr]:=tinhgt(1,3);
        a:=b;d:=e;
        a[2]:=ccl(a[1],a[2],d[1]);
        inc(nr);res[nr]:=ccl(a[2],a[3],d[2]);
        a:=b;d:=e;
        a[2]:=ccl(a[2],a[3],d[2]);
        inc(nr);res[nr]:=ccl(a[1],a[2],d[1]);
end;

procedure process3;
begin
        inc(nr);
        res[nr]:=tinhgt(1,n);
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=res[random(r-l+1)+l];
        repeat
                while res[i]<t do inc(i);
                while res[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=res[i];res[i]:=res[j];res[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure result;
var     i,j,cou:longint;
begin
        sort(1,nr);
        res[0]:=-oo;
        cou:=nr;
        for i:=1 to nr do
                if res[i]=res[i-1] then dec(cou);
        writeln(cou);
        for i:=1 to nr do
                if res[i]<>res[i-1] then write(res[i],' ');
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(st);
        nr:=0;
        while st>0 do
        begin
                enter;
                if n=4 then process1 else
                if n=3 then process2 else
                process3;
                dec(st);
        end;
        result;
        close(input);close(output);
end.
