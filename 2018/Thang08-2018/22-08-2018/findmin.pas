const   ginp='findmin.inp';
        gout='findmin.out';
        maxn=100010;

type    save=record i,j:longint;g:int64;end;

var     m,n,k,nh:longint;
        a,b:array[0..maxn] of int64;
        h:array[0..maxn] of save;

procedure sort(l,r:longint;var d:array of int64);
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure enter;
var     i:longint;
begin
        readln(m,n,k);
        for i:=1 to m do read(a[i]);
        sort(1,m,a);
        for i:=1 to n do read(b[i]);
        sort(1,n,b);
end;

procedure swap(var x,y:save);
var     tm:save;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure uph(i:longint);
var     j:longint;
begin
        j:=i shr 1;
        if j=0 then exit;
        if h[i].g<h[j].g then
        begin
                swap(h[i],h[j]);
                uph(j);
        end;
end;

procedure push(i,j:longint);
begin
        inc(nh);
        h[nh].i:=i;h[nh].j:=j;
        h[nh].g:=a[i]+b[j];
        uph(nh);
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (h[j].g>h[j+1].g) then inc(j);
        if h[i].g>h[j].g then
        begin
                swap(h[i],h[j]);
                downh(j);
        end;
end;

function pop:save;
begin
        pop:=h[1];
        h[1]:=h[nh];
        dec(nh);
        downh(1);
end;

procedure process;
var     i:longint;
        p:save;
begin
        nh:=0;
        for i:=1 to m do push(i,1);
        for i:=1 to k do
        begin
                p:=pop;
                writeln(p.g);
                if p.j<n then push(p.i,p.j+1);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
