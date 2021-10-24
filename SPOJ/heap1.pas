const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,nh:longint;
        ans:int64;
        a,h:array[0..20001] of int64;

procedure swap(var x,y:int64);
var     tm:int64;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nh then exit;
        if (j<nh) and (h[j]>h[j+1]) then inc(j);
        if h[i]>h[j] then
        begin
                swap(h[i],h[j]);
                downh(j);
        end;
end;

procedure uph(i:longint);
var     j:longint;
begin
        if i<=1 then exit;
        j:=i div 2;
        if h[i]<h[j] then
        begin
                swap(h[i],h[j]);
                uph(j);
        end;
end;

function pop:int64;
begin
        pop:=h[1];
        swap(h[1],h[nh]);
        dec(nh);
        downh(1);
end;

procedure push(x:int64);
begin
        inc(nh);
        h[nh]:=x;
        uph(nh);
end;

procedure process;
var     i:longint;
        tm1,tm2:int64;
begin
        nh:=0;ans:=0;
        for i:=1 to n do push(a[i]);
        while nh<>1 do
        begin
                tm1:=pop;tm2:=pop;
                ans:=ans+tm1+tm2;
                push(tm1+tm2);
        end;
end;

procedure main;
var     i,st,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        for i:=1 to st do
        begin
                readln(gi,n);
                for j:=1 to n do read(gi,a[j]);
                process;
                writeln(go,ans);readln(gi);
        end;
        close(gi);close(go);
end;

begin
        main;
end.
