const   ginp='ss.inp';
        gout='ss.out';
        maxn=100010;

var     n,modul,k,cou:longint;
        res:int64;
        s:array[0..maxn] of int64;
        a,b,c:array[0..maxn] of longint;
        d:array[0..3*maxn] of int64;
        f:array[0..12*maxn] of longint;

procedure sort(l,r:longint; var d:array of int64; var v:array of longint);
var     i,j,t,tt:longint;
        tmp:int64;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        tt:=v[i]; v[i]:=v[j]; v[j]:=tt;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d,v); sort(i,r,d,v);
end;

function quece(id,l,r,dd,cc:longint):longint;
var     mid:longint;
begin
        if (cc<l) or (dd>r) then exit(0);
        if (dd<=l) and (r<=cc) then exit(f[id]);
        mid:=(l+r) shr 1;
        quece:=quece(id*2+1,mid+1,r,dd,cc);
        if quece=0 then quece:=quece(id*2,l,mid,dd,cc);
end;

procedure update(id,l,r,v:longint);
var     mid:longint;
begin
        if (v<l) or (v>r) then exit;
        if (v=l) and (r=v) then
        begin
                f[id]:=l; exit;
        end;
        mid:=(l+r) shr 1;
        update(id*2,l,mid,v); update(id*2+1,mid+1,r,v);
        if f[id*2+1]>0 then f[id]:=f[id*2+1] else f[id]:=f[id*2];
end;

procedure enter;
var     i:longint;
        v:array[0..3*maxn] of longint;
begin
        readln(n,k,modul);
        for i:=1 to n do
        begin
                readln(s[i]); s[i]:=(s[i]+s[i-1]) mod modul;
                d[i]:=s[i]; v[i]:=i;
                d[i+n]:=s[i]-k; v[i+n]:=i+n;
                d[i+2*n]:=s[i]-modul; v[i+2*n]:=i+2*n;
        end;
        sort(1,3*n,d,v);
        cou:=0; d[0]:=-modul-1;
        for i:=1 to 3*n do
        begin
                if d[i]>d[i-1] then
                begin
                        inc(cou); d[cou]:=d[i];
                end;
                if v[i]<=n then a[v[i]]:=cou else
                if v[i]<=2*n then b[v[i]-n]:=cou else
                c[v[i]-2*n]:=cou;
        end;
end;

procedure process;
var     i,v:longint;
begin
        res:=-1;
        for i:=1 to n do
        begin
                v:=quece(1,1,cou,c[i]+1,b[i]);
                if (v>0) and ((res=-1) or (res>s[i]-d[v])) then res:=s[i]-d[v];
                update(1,1,cou,a[i]); update(1,1,cou,c[i]);
        end;
        if res>-1 then write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
