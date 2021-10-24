const   ginp='ngoac.inp';
        gout='ngoac.out';
        oo=trunc(1e9);

var     n,q,nhm,nhd:longint;
        sum,mi,hm,hd:array[0..300010] of longint;
        s:ansistring;

procedure upsum(i,x:longint);
begin
        if i>n then exit;
        sum[i]:=sum[i]+x;
        upsum(i+i and (-i),x);
end;

function qsum(i:longint):longint;
begin
        if i<1 then exit(0);
        qsum:=qsum(i-i and (-i))+sum[i];
end;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure uph(var i:longint;var h:array of longint);
var     j:longint;
begin
        j:=i shr 1;
        if j<1 then exit;
        if h[i]<h[j] then
        begin
                swap(h[i],h[j]);
                uph(j,h);
        end;
end;

procedure push(i:longint;var nh:longint;var h:array of longint);
begin
        inc(nh);
        h[nh]:=i;
        uph(nh,h);
end;

procedure downh(i,nh:longint;var h:array of longint);
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (h[j+1]<h[j]) then inc(j);
        if h[i]>h[j] then
        begin
                swap(h[i],h[j]);
                downh(j,nh,h);
        end;
end;

function pop(var nh:longint;var h:array of longint):longint;
begin
        pop:=h[1];
        h[1]:=h[nh];
        dec(nh);
        downh(1,nh,h);
end;

procedure enter;
var     i,tm:longint;
begin
        readln(n,q);
        readln(s);
        tm:=0;nhm:=0;nhd:=0;
        for i:=1 to n do mi[i]:=oo;
        for i:=1 to n do
        begin
                if (tm>0) and (s[i]='(') then push(i,nhm,hm);
                if s[i]=')' then push(i,nhd,hd);
                if s[i]='(' then
                begin
                        tm:=tm+1;
                        upsum(i,1);
                end else
                begin
                        tm:=tm-1;
                        upsum(i,-1);
                end;
        end;
end;

procedure process;
var     i,v,vr:longint;
begin
        for i:=1 to q do
        begin
                readln(v);
                if s[v]='(' then
                begin
                        if (nhd=0) or (hd[1]>v) then writeln(v) else
                        begin
                                vr:=pop(nhd,hd);
                                writeln(vr);
                                upsum(vr,2);s[vr]:='(';
                                if qsum(vr-1)>0 then push(vr,nhm,hm);
                                upsum(v,-2);s[v]:=')';
                                push(v,nhd,hd);
                        end;
                end else
                begin
                        if (nhm=0) or (hm[1]>v) then writeln(v) else
                        begin
                                vr:=pop(nhm,hm);
                                writeln(vr);
                                upsum(vr,-2);s[vr]:=')';
                                push(vr,nhd,hd);
                                upsum(v,2);s[v]:='(';
                                if qsum(v-1)>0 then push(v,nhm,hm);
                        end;
                end;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
