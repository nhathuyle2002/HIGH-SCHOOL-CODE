const   ginp='phanthuong.inp';
        gout='phanthuong.out';
        kk=1000000007;

var     gi,go:text;
        n,k:longint;
        a:array[0..100010] of longint;
        ans:int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do read(gi,a[i]);
end;

procedure sort(l,r:longint);
var     i,j,tm,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]>t do inc(i);
                while a[j]<t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];
                        a[i]:=a[j];
                        a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function tgt(x:int64;i:longint):int64;
begin
        if i=0 then exit(1);
        if i=1 then exit(x);
        tgt:=sqr(tgt(x,i div 2)) mod kk;
        if i mod 2=1 then tgt:=(tgt*x) mod kk;
end;

procedure process;
var     i,tm:longint;
        tmp:int64;
        gt:array[0..100010] of int64;
begin
        ans:=0;
        {if k=1 then
        begin
                for i:=1 to n do ans:=ans+a[i];
                exit;
        end;  }
        dec(k);
        gt[0]:=1;
        for i:=1 to n do gt[i]:=(gt[i-1]*i) mod kk;
        tm:=n;
        for i:=1 to n do
        begin
                dec(tm);
                if tm<k then exit;
                tmp:=(a[i]*gt[tm]) mod kk;
                tmp:=(tmp*tgt((gt[k]*gt[tm-k]) mod kk,kk-2)) mod kk;
                ans:=(ans+tmp) mod kk;
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.














