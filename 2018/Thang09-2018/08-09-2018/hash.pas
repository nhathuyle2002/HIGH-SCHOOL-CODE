const   ginp='hash.inp';
        gout='hash.out';
        base=10;

type    bignum=array[0..510] of longint;

var     n,m,maxk:longint;
        b:array[0..1710] of bignum;
        a,c:array[0..5010] of bignum;

function cmp(a,b:bignum):boolean;
var     i:longint;
begin
        if a[0]<b[0] then exit(true);
        if a[0]>b[0] then exit(false);
        for i:=a[0] downto 1 do
                if a[i]<b[i] then exit(true) else
                if a[i]>b[i] then exit(false);
        exit(false);
end;

procedure copy(var a,b:bignum);
var     i:longint;
begin
        a[0]:=b[0];
        for i:=1 to b[0] do a[i]:=b[i];
end;

operator * (a:bignum; b:longint) c:bignum;
var     i,rem:longint;
begin
        rem:=0; c[0]:=a[0];
        for i:=1 to c[0] do
        begin
                c[i]:=a[i]*b+rem;
                if c[i]<base then rem:=0 else
                begin
                        rem:=c[i] div base;
                        c[i]:=c[i] mod base;
                end;
        end;
        while rem>0 do
        begin
                inc(c[0]);
                c[c[0]]:=rem mod base;
                rem:=rem div base;
        end;
end;

operator + (a:bignum; b:longint) c:bignum;
var     i,rem:longint;
begin
        rem:=b; c[0]:=a[0];
        for i:=1 to c[0] do
        begin
                c[i]:=a[i]+rem;
                if c[i]>=base then
                begin
                        rem:=1;
                        c[i]:=c[i]-base;
                end
                else    rem:=0;
        end;
        if rem>0 then
        begin
                inc(c[0]);
                c[c[0]]:=rem;
        end;
end;

operator - (a,b:bignum) c:bignum;
var     i,rem:longint;
begin
        rem:=0; c[0]:=a[0];
        for i:=1 to c[0] do
        begin
                if i>b[0] then b[i]:=0;
                c[i]:=a[i]-b[i]-rem;
                if c[i]<0 then
                begin
                        rem:=1;
                        c[i]:=c[i]+base;
                end
                else    rem:=0;
        end;
        while (c[0]>0) and (c[c[0]]=0) do dec(c[0]);
end;

function b_mod(a,b:bignum):bignum;
var     i,k:longint;
        kb:array[0..10] of bignum;
        c:bignum;
begin
        kb[0,0]:=0;
        for k:=1 to 10 do kb[k]:=b*k;
        c[0]:=0;
        for i:=a[0] downto 1 do
        begin
                c:=c*10+a[i]; k:=1;
                while not cmp(c,kb[k]) do inc(k);
                c:=c-kb[k-1];
        end;
        b_mod:=c;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tmp:bignum;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while cmp(c[i],t) do inc(i);
                while cmp(t,c[j]) do dec(j);
                if i<=j then
                begin
                        copy(tmp,c[i]);copy(c[i],c[j]);copy(c[j],tmp);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i,j:longint;
        c:ansistring;
        maxa:bignum;
begin
        readln(n,m); inc(m);
        maxa[0]:=0;
        for i:=1 to n do
        begin
                readln(c);
                a[i,0]:=length(c);
                for j:=1 to a[i,0] do a[i,j]:=ord(c[a[i,0]-j+1])-48;
                if cmp(maxa,a[i]) then copy(maxa,a[i]);
        end;
        b[0,0]:=1; b[0,1]:=1;
        maxk:=0;
        repeat
                inc(maxk);
                b[maxk]:=b[maxk-1]*m;
        until cmp(maxa,b[maxk]);
end;

procedure process;
var     left,right,mid,i:longint;
begin
        left:=1;right:=maxk;
        while left<right do
        begin
                mid:=(left+right) shr 1;
                for i:=1 to n do
                        c[i]:=b_mod(a[i],b[mid]);
                sort(1,n);
                for i:=2 to n+1 do
                        if not cmp(c[i-1],c[i]) then break;
                if i=n+1 then right:=mid else left:=mid+1;
        end;
        write(left);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
