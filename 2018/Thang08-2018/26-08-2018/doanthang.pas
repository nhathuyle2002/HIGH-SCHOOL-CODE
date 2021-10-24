const   ginp='doanthang.inp';
        gout='doanthang.out';
        maxn=2000001;

var     n,res:longint;
        a,b:array[0..100010] of longint;
        f:array[0..maxn] of longint;

procedure sort(l,r:longint);
var     i,j,t,tt,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=random(r-l+1)+l;
        tt:=a[t];t:=b[t];
        repeat
                while (b[i]>t) or ((b[i]=t) and (a[i]<tt)) do inc(i);
                while (b[j]<t) or ((b[j]=t) and (a[j]>tt)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        tm:=b[i];b[i]:=b[j];b[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                readln(a[i],b[i]);
                a[i]:=a[i]+1000001;
        end;
        sort(1,n);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function get(i:longint):longint;
begin
        if i<1 then exit(0);
        get:=max(f[i],get(i-i and (-i)));
end;

procedure update(i,x:longint);
begin
        if i>maxn then exit;
        f[i]:=max(f[i],x);
        update(i+i and (-i),x);
end;

procedure process;
var     i,j,tm:longint;
begin
        fillchar(f,sizeof(f),0);
        res:=0;
        for i:=1 to n do
        begin
                tm:=get(a[i]);
                res:=max(res,tm+1);
                update(a[i],tm+1);
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
