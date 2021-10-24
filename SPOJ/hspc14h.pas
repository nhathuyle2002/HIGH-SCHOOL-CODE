const   ginp='ss.inp';
        gout='ss.out';

type    dat=record ty:char;sl:longint;end;

var     gi,go:text;
        m,n:longint;
        a:array[0..1501,0..1501] of dat;
        t,c,f:array[0..1501,0..1501] of int64;

procedure input;
var     i,j:longint;
        s,tm:ansistring;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do
        begin
                readln(gi,s);
                s:=s+' ';
                for j:=1 to n do
                begin
                        while s[1]=' ' do delete(s,1,1);
                        tm:='';
                        while s[1]<>' ' do
                        begin
                                tm:=tm+s[1];
                                delete(s,1,1);
                        end;
                        a[i,j].ty:=tm[1];delete(tm,1,1);
                        val(tm,a[i,j].sl);
                end;
        end;
end;

function max(x,y,z:int64):int64;
begin
        max:=x;
        if y>max then max:=y;
        if z>max then max:=z;
end;

procedure process;
var     i,j:longint;
        pp1,pp2,pp3:int64;
begin
        for i:=1 to m do
                for j:=1 to n do
                begin
                        t[i,j]:=t[i-1,j]+t[i,j-1]-t[i-1,j-1];
                        c[i,j]:=c[i-1,j]+c[i,j-1]-c[i-1,j-1];
                        if a[i,j].ty='A' then t[i,j]:=t[i,j]+a[i,j].sl
                        else c[i,j]:=c[i,j]+a[i,j].sl;
                end;
        for i:=2 to m do
                for j:=2 to n do
                begin
                        pp1:=f[i-1,j]+t[i,j-1]-t[i-1,j-1];
                        pp2:=f[i,j-1]+c[i-1,j]-c[i-1,j-1];
                        pp3:=f[i-1,j-1]+t[i,j-1]-t[i-1,j-1]+c[i-1,j]-c[i-1,j-1];
                        f[i,j]:=max(pp1,pp2,pp3);
                end;
end;

procedure output;
var     i:longint;
begin
        write(go,f[m,n]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.











