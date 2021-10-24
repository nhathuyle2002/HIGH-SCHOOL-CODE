const   ginp='wall.inp';
        gout='wall.out';
        oo=trunc(1e8)*3;

var     gi,go:text;
        n,m,res,cou:longint;
        a,b,c:array[0..100010] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);readln(gi,m);
        for i:=1 to m do read(gi,b[i]);
end;

procedure process;
var     i,j,l,r,mid:longint;
        ok:boolean;
begin
        l:=1;r:=oo;
        while l<r do
        begin
                mid:=(l+r)>>1;
                j:=1;ok:=true;
                for i:=1 to n do
                if a[i]<mid then
                begin
                        while (j<=m+1) and (a[i]+b[j]<mid) do inc(j);
                        inc(j);
                        if j>m+1 then
                        begin
                                ok:=false;
                                break;
                        end;
                end;
                if ok then l:=mid+1 else r:=mid;
        end;
        res:=l-1;
        j:=1;cou:=0;
        for i:=1 to n do
                if a[i]>=res then c[i]:=0 else
                begin
                        inc(cou);
                        while a[i]+b[j]<res do inc(j);
                        c[i]:=j;
                        inc(j);
                end;
        writeln(go,res,' ',cou);
        for i:=1 to n do
                if c[i]<>0 then writeln(go,i,' ',c[i]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
