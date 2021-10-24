const   ginp='photo.inp';
        gout='photo.out';

var     gi,go:text;
        n,low,high,maxsum:longint;
        cs,a:array[0..100010] of longint;

procedure input;
var     i,x,y:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,maxsum);
        readln(gi,low,high);
        for i:=1 to n do
        begin
                readln(gi,x,y);
                a[i]:=x*low+y*high;
                cs[i]:=i;
        end;
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;
        x:=y;
        y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,num,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=random(r-l+1)+l;
        num:=cs[t];
        t:=a[t];
        repeat
                while (a[i]<t) or ((a[i]=t) and (num<cs[i])) do inc(i);
                while (a[j]>t) or ((a[j]=t) and (num>cs[j])) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(cs[i],cs[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure output;
var     i,cou,sum:longint;
begin
        sum:=0;
        cou:=0;
        for i:=1 to n do
                if sum+a[i]<=maxsum then
                begin
                        sum:=sum+a[i];
                        inc(cou);
                end
                else break;
        writeln(go,cou);
        for i:=1 to cou do write(go,cs[i],' ');
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        output;
end.
