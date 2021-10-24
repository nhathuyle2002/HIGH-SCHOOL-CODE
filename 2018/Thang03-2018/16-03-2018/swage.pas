const   ginp='swage.inp';
        gout='swage.out';

var     gi,go:text;
        n,nn,ans,vt:longint;
        x,y:array[0..2001] of longint;
        a,b,c:array[0..2001] of real;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,x[i],y[i]);
end;

procedure tdt(i,j:longint);
var     tmp1,tmp2,tmp3:longint;
begin
        inc(nn);
        tmp1:=y[i]-y[j];
        tmp2:=x[j]-x[i];
        tmp3:=-tmp1*x[i]-tmp2*y[i];
        if (tmp1=0) and (tmp2=0) then
        begin
                a[nn]:=0;b[nn]:=0;c[nn]:=0;
                exit;
        end;
        if (tmp1=0) then
        begin
                a[nn]:=0;b[nn]:=1;c[nn]:=tmp3/tmp2;
                exit;
        end;
        if (tmp2=0) then
        begin
                a[nn]:=1;b[nn]:=0;c[nn]:=tmp3/tmp1;
                exit;
        end;
        a[nn]:=1;b[nn]:=tmp2/tmp1;c[nn]:=tmp3/tmp1;
end;

procedure swap(var xx,yy:real);
var     tmp:real;
begin
        tmp:=xx;
        xx:=yy;
        yy:=tmp;
end;

function sosanh(i,j:longint):boolean;
begin
        if a[j]>a[i] then exit(false);
        if a[i]<a[j] then exit(true);
        if b[i]<b[j] then exit(true);
        if b[i]>b[j] then exit(false);
        if c[i]<c[j] then exit(true);
        exit(false);
end;

procedure sort(l,r:longint);
var     x,i,j:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=random(r-l+1)+l;
        repeat
                while sosanh(i,x) do inc(i);
                while sosanh(x,j) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        swap(c[i],c[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);
        sort(i,r);
end;

function max(xx,yy:longint):longint;
begin
        if xx>yy then exit(xx) else exit(yy);
end;

function cdt(i,j:longint):boolean;
begin
        if a[i]<>a[j] then exit(false);
        if b[i]<>b[j] then exit(false);
        if c[i]<>c[j] then exit(false);
        exit(true);
end;

procedure cclt;
var     i,dem,tmp:longint;
begin
        a[0]:=0;b[0]:=0;c[0]:=0;
        i:=0;tmp:=1;
        while (cdt(0,i+1)) and (i<nn) do
        begin
                inc(tmp);
                inc(i);
        end;
        ans:=max(ans,tmp);
        if tmp=nn+1 then exit;
        repeat
                dem:=tmp+1;
                inc(i);
                while (i<nn) and (cdt(i,i+1)) do
                begin
                        inc(i);
                        inc(dem);
                end;
                ans:=max(ans,dem);
        until (i>=nn);
end;

procedure edit;
var     i:longint;
begin
        vt:=1;
        for i:=1 to nn do
                if cdt(0,i) then
                begin
                        swap(a[i],a[vt]);
                        swap(b[i],b[vt]);
                        swap(c[i],c[vt]);
                        inc(vt);
                end;
end;

procedure process;
var     i,j:longint;
begin
        if n=1 then
        begin
                ans:=1;
                exit;
        end;
        ans:=0;
        fillchar(a,sizeof(a),0);
        fillchar(b,sizeof(b),0);
        fillchar(c,sizeof(c),0);
        for i:=1 to n-1 do
        begin
                nn:=0;
                for j:=1 to n do
                        if (i<>j) then tdt(i,j);
                edit;
                sort(vt,nn);
                cclt;
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.







