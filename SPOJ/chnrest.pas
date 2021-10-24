const   ginp='ss.inp';
        gout='ss.out';
        maxm=30;
        maxn=10;
        maxch=59049;

var     m,n,pos,count:longint;
        res,sum:int64;
        dd:array[0..maxn] of longint;
        cost:array[0..maxm] of int64;
        d:array[0..maxn,0..maxm] of boolean;
        m3:array[0..maxm shr 1] of longint;
        f,l,r:array[0..maxch] of int64;

procedure load(j:longint);
var     i:longint;
begin
        sum:=sum+cost[j];
        for i:=1 to n do
                if d[i,j] then
                begin
                        inc(dd[i]);
                        if dd[i]=3 then inc(count);
                        pos:=pos+m3[i];
                end;
end;

procedure unload(j:longint);
var     i:longint;
begin
        sum:=sum-cost[j];
        for i:=1 to n do
                if d[i,j] then
                begin
                        if dd[i]=3 then dec(count);
                        dec(dd[i]);
                        pos:=pos-m3[i];
                end;
end;

procedure dequy(i,last:longint);
var     j:longint;
begin
        for j:=i to last do
        begin
                load(j);
                if count=0 then
                begin
                        if (f[pos]=-1) or (sum<f[pos]) then f[pos]:=sum;
                        dequy(j+1,last);
                end;
                unload(j);
        end;
end;

procedure enter;
var     i,x:longint;
begin
        readln(m,n);
        for i:=1 to m do read(cost[i]);
        readln;
        fillchar(d,sizeof(d),false);
        for i:=1 to n do
        begin
                while not seekeoln do
                begin
                        read(x);
                        d[i,x]:=true;
                end;
                readln;
        end;
        m3[1]:=1;
        for i:=2 to n+1 do m3[i]:=m3[i-1]*3;
end;

procedure process;
var     i,ii:longint;
begin
        sum:=0; pos:=0; count:=0;
        for i:=1 to m3[n+1]-1 do f[i]:=-1;
        dequy(1,m shr 1);
        l:=f;
        for i:=1 to m3[n+1]-1 do f[i]:=-1;
        dequy(m shr 1+1,m);
        r:=f;
        res:=-1;
        for i:=0 to m3[n+1]-1 do
        begin
                ii:=m3[n+1]-1-i;
                if (l[i]>-1) and (r[ii]>-1) and ((res=-1) or (l[i]+r[ii]<res)) then res:=l[i]+r[ii];
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
