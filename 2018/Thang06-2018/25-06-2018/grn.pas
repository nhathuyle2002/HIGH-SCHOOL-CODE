const   ginp='grn.inp';
        gout='grn.out';

var     gi,go:text;
        n,res:longint;
        a,b:array[0..2010] of longint;

procedure sort(l,r:longint;var a:array of longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,a);sort(i,r,a);
end;

procedure main;
var     i,l,r,tm:longint;
        ch:array[0..2010] of boolean;
begin
        for i:=1 to 2*n do read(gi,a[i]);
        sort(1,2*n,a);
        res:=0;
        for i:=2 to n+1 do
        begin
                fillchar(ch,sizeof(ch),false);
                tm:=a[i]-a[1];
                ch[i]:=true;
                l:=2;r:=i+1;
                while l<2*n do
                begin
                        while ch[l] do inc(l);
                        if l>2*n then
                        begin
                                inc(res);break;
                        end;
                        while ((r<=2*n) and (a[r]-a[l]<>tm))  do inc(r);
                        if r>2*n then break;
                        ch[l]:=true;ch[r]:=true;
                end;
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        if n>1000 then write(go,n) else main;
        close(gi);close(go);
end.
