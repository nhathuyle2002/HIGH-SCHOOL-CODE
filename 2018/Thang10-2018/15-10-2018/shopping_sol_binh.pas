const   fi='SHOPPING.inp';
        fo='SHOPPING.out';
        mn = 500005;
type    Mg =Record
        v,p: longint;
        end;

var     ct,i,n,m:longint;
        t: array[0..mn*2,0..1] of longint;
        a,b,c,pre,nex: array[0..mn] of longint;
        d: array[0..mn*2] of Mg;

function max(a,b: longint):longint;
begin
        if a>b then exit(a) else exit(b);
end;

function min(a,b: longint):longint;
begin
        if a<b then exit(a) else exit(b);
end;

procedure qs(l,r: longint);
var     i,j,x:longint;
        t:mg;
begin
        if l>=r then exit;
        i:=l; j:=r;
        x:= d[random(r-l+1)+l].v;
        repeat
                while d[i].v<x do i:=i+1;
                while d[j].v>x do j:=j-1;
                if i<=j then
                begin
                        t:=d[i]; d[i]:=d[j]; d[j]:=t;
                        i:=i+1; j:=j-1;
                end;
        until i>j;
        qs(l,j); qs(i,r);
end;

procedure archive;
var     i: longint;
begin
        for i:=1 to n do
        begin
                d[i].v:= a[i];
                d[i].p:= i;
                d[i+n].v:= m-a[i];
                d[i+n].p:= -i;
        end;
        qs(1,2*n);
        d[0].v:= -1;
        for i:=1 to 2*n do
        begin
                if d[i].v>d[i-1].v then inc(ct);
                if d[i].p >0 then b[d[i].p]:= ct else c[-d[i].p]:=ct;
        end;
end;

procedure update(i,f,k1,k2:longint);
begin
        if k1=1 then i:=ct-i+1;
        while i<=ct do
        begin
                if k2=0 then
                t[i,k1]:=max(t[i,k1],f) else
                t[i,k1]:=min(t[i,k1],f);
                i:=i + i and (-i);
        end;
end;

function get(i,k1,k2: longint):longint;
begin
        get:= 0;
        if k1=1 then i:=ct-i+1;
        if k2=1 then get:=n+1;
        while i>0 do
        begin
                if k2=0 then get:= max(get,t[i,k1])else
                get:= min(get,t[i,k1]);
                i:=i - i and (-i);
        end;
end;

procedure main;
var     i,j:longint;
        kq: int64;
begin
        Archive;
        kq:=0;
        for i:=1 to n do
        begin
                pre[i]:= max(get(c[i]+1,1,0),get(b[i]-1,0,0));
                update(b[i],i,0,0);
                update(b[i],i,1,0);
        end;
        for i:=1 to ct do
        for j:=0 to 1 do t[i,j]:=n+1;
        for i:=n downto 1 do
        begin
                nex[i]:=min(get(b[i],0,1),get(c[i]+1,1,1));
                update(b[i],i,0,1);
                update(b[i],i,1,1);
        end;
        for i:=1 to n do
        begin
                kq:=kq + (nex[i]-i)*(i-pre[i]) ;
                if a[i]*2 > m then dec(kq);
        end;
        write(kq);
end;

begin
        assign(input,fi);  assign(output,fo);
        reset(input);      rewrite(output);
        readln(n,m);
        for i:=1 to n do read(A[i]);
        main;
        close(input);      close(output);
end.