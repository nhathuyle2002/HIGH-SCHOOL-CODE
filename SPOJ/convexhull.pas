type    point=record x,y:longint; end;

const   ginp='convexhull.inp';
        gout='convexhull.out';

var     n,tb,tc:longint;
        sb,sc:int64;
        a,b,c:array[0..10] of point;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do readln(a[i].x,a[i].y);
end;

function dt(x,y,z:point):int64;
begin
        dt:=(y.x-x.x)*(y.y+x.y);
        dt:=dt+(z.x-y.x)*(z.y+y.y);
        dt:=dt+(x.x-z.x)*(x.y+z.y);
end;

function cnp(p:point;top:longint;q:array of point):longint;
var     r,l,m:longint;
begin
        if (p.x<q[1].x) or ((p.x=q[1].x) and (p.y<q[1].y)) then exit(1);
        if (p.x>q[top].x) or ((p.x=q[top].x) and (p.y>q[top].y)) then exit(top+1);
        l:=1;r:=top;
        while l<r do
        begin
                m:=(l+r) shr 1;
                if (q[m].x<p.x) or ((q[m].x=p.x) and (q[m].y<p.y)) then l:=m+1 else r:=m;
        end;
        exit(l);
end;

procedure cnb(p:point);
var     i,tq,vt:longint;
        q:array[0..10] of point;
begin
        vt:=cnp(p,tb,b);
        if (vt<>1) and (vt<>tb+1) then
        if dt(b[vt-1],p,b[vt])<=0 then exit;
        for i:=tb+1 downto vt+1 do b[i]:=b[i-1];b[vt]:=p;
        inc(tb);
        q:=b;tq:=tb;tb:=2;
        for i:=3 to tq do
        begin
                while (tb>=2) and (dt(b[tb-1],b[tb],q[i])<=0) do dec(tb);
                inc(tb);b[tb]:=q[i];
        end;
        b[tb+1]:=b[1];sb:=0;
        for i:=2 to tb+1 do sb:=sb+(b[i].x-b[i-1].x)*(b[i].y+b[i-1].y);
end;

procedure cnc(p:point);
var     i,tq,vt:longint;
        q:array[0..10] of point;
begin
        vt:=cnp(p,tc,c);
        if (vt<>1) and (vt<>tc+1) then
        if dt(c[vt],p,c[vt-1])<=0 then exit;
        for i:=tc+1 downto vt+1 do c[i]:=c[i-1];c[vt]:=p;
        inc(tc);
        q:=c;tq:=tc;tc:=tq-1;
        for i:=tq-2 downto 1 do
        begin
                while (tc<=tq-1) and (dt(c[tc+1],c[tc],q[i])<=0) do inc(tc);
                dec(tc);c[tc]:=q[i];
        end;
        for i:=1 to tq-tc+1 do c[i]:=c[i+tc-1];
        tc:=tq-tc+1;c[0]:=c[tc];sc:=0;
        for i:=tc downto 1 do sc:=sc+(c[i-1].x-c[i].x)*(c[i-1].y+c[i].y);
end;

procedure process;
var     i:longint;
begin
        writeln('0.0');
        b[1]:=a[1];tb:=1;
        c[1]:=a[1];tc:=1;
        for i:=2 to n do
        begin
                cnb(a[i]);cnc(a[i]);
                write((sb+sc) div 2);
                if (sb+sc) mod 2=0 then writeln('.0') else writeln('.5');
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

