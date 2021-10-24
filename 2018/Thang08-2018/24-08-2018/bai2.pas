const   ginp='bai2.inp';
        gout='bai2.out';

var     nh,n,res:longint;
        h:array[0..15010] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure uph(i:longint);
var     j:longint;
begin
        j:=i shr 1;
        if j<1 then exit;
        if h[i]<h[j] then
        begin
                swap(h[i],h[j]);
                uph(j);
        end;
end;

procedure push(x:longint);
begin
        inc(nh);
        h[nh]:=x;
        uph(nh);
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (h[j]>h[j+1]) then inc(j);
        if h[i]>h[j] then
        begin
                swap(h[i],h[j]);
                downh(j);
        end;
end;

function pop:longint;
begin
        pop:=h[1];
        h[1]:=h[nh];
        dec(nh);
        downh(1);
end;

procedure enter;
var     i,x:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                read(x);
                push(x);
        end;
end;

procedure process;
var     i,x:longint;
begin
        res:=0;
        for i:=1 to n-1 do
        begin
                x:=pop+pop;
                res:=res+x;
                push(x);
        end;
        write(res/100*5:0:2);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
