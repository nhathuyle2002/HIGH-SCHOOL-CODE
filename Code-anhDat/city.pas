const   ginp='city.inp';
        gout='city.out';

var     n,nx,ny,nz,nh:longint;
        a,b,c,h:array[0..100010] of longint;
        fb,fc:array[0..100010] of int64;
        suma,sum,res:int64;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=random(r-l+1)+l;t:=b[t]-c[t];
        repeat
                while b[i]-c[i]>t do inc(i);
                while b[j]-c[j]<t do dec(j);
                if i<=j then
                begin
                        swap(b[i],b[j]);
                        swap(c[i],c[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(nx,ny,nz);
        n:=nx+ny+nz;
        for i:=1 to n do
        begin
                readln(a[i],b[i],c[i]);
                suma:=suma+a[i];
                b[i]:=b[i]-a[i];
                c[i]:=c[i]-a[i];
        end;
        sort(1,n);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure uph(i:longint);
var     j:longint;
begin
        if i<=1 then exit;
        j:=i shr 1;
        if h[i]<h[j] then
        begin
                swap(h[i],h[j]);
                uph(j);
        end;
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

procedure push(x:longint);
begin
        inc(nh);
        h[nh]:=x;
        uph(nh);
end;

function pop:longint;
begin
        pop:=h[1];
        h[1]:=h[nh];
        dec(nh);
        downh(1);
end;

procedure process;
var     i:longint;
begin
        nh:=0;sum:=0;
        for i:=1 to ny do
        begin
                push(b[i]);
                sum:=sum+b[i];
        end;
        fb[ny]:=sum;
        for i:=ny+1 to n-nz do
        begin
                push(b[i]);
                sum:=sum+b[i]-pop;
                fb[i]:=sum;
        end;
        nh:=0;sum:=0;
        for i:=n downto n-nz+1 do
        begin
                push(c[i]);
                sum:=sum+c[i];
        end;
        fc[n-nz+1]:=sum;
        for i:=n-nz downto ny+1 do
        begin
                push(c[i]);
                sum:=sum+c[i]-pop;
                fc[i]:=sum;
        end;
        res:=0;
        for i:=ny to n-nz do
                if fb[i]+fc[i+1]>res then res:=fb[i]+fc[i+1];
        write(res+suma);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

