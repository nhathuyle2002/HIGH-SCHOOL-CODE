const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,k:longint;
        ans:int64;
        s,s0:array[0..1001] of int64;
        c:array[0..1001] of longint;

function shtg(x0,y0,x1,y1,x2,y2:int64):int64;
begin
        shtg:=(x1-x0)*(y2-y0)-(x2-x0)*(y1-y0);
        if shtg<0 then shtg:=-shtg;
end;

procedure input;
var     i,j,m:longint;
        x,y:array[0..1001] of int64;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do
        begin
                read(gi,m,c[i]);
                for j:=1 to m do read(gi,x[j],y[j]);
                readln(gi);
                s[i]:=0;
                for j:=2 to m-1 do s[i]:=s[i]+shtg(x[1],y[1],x[j],y[j],x[j+1],y[j+1]);
        end;
end;

procedure sort(l,r:longint);
var     i,j,tmp:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=s[random(r-l+1)+l];
        repeat
                while s[i]<t do inc(i);
                while s[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=s[i];s[i]:=s[j];s[j]:=tm;
                        tmp:=c[i];c[i]:=c[j];c[j]:=tmp;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,l,r:longint;
        d:array[-1001..2001] of int64;
begin
        for i:=1 to n do s0[i]:=s[i]-s[i-1];
        ans:=0;
        for i:=1 to n do
        begin
                fillchar(d,sizeof(d),0);
                l:=i;r:=i;
                for j:=i downto 1 do
                        if c[j]=c[i] then d[l]:=d[l]+s0[j]
                        else begin
                                dec(l);
                                d[l]:=s0[j];
                        end;
                for j:=i+1 to n do
                        if c[j]=c[i] then d[r]:=d[r]+s0[j]
                        else begin
                                inc(r);
                                d[r]:=s0[j];
                        end;
                for j:=1 to n do d[j]:=d[j-1]+d[j];
                for j:=i to i+k do ans:=max(ans,d[j]-d[j-k-1]);
        end;
end;

procedure output;
begin
        write(go,ans/2:0:1);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.
