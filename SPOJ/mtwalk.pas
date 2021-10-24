const   ginp='ss.inp';
        gout='ss.out';
        di:array[1..4] of integer=(1,0,0,-1);
        dj:array[1..4] of integer=(0,1,-1,0);

var     gi,go:text;
        n,left,right,gmax,gmin,ans:integer;
        d:array[0..101,0..101] of boolean;
        a:array[0..101,0..101] of integer;

procedure input;
var     i,j:integer;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        gmax:=0;gmin:=110;
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,a[i,j]);
                        if gmax<a[i,j] then gmax:=a[i,j];
                        if gmin>a[i,j] then gmin:=a[i,j];
                end;
                readln(gi);
        end;
end;

procedure check(i,j:integer);
var     k,i0,j0:integer;
begin
        if d[n,n]=false then exit;
        d[i,j]:=false;
        for k:=1 to 4 do
        begin
                i0:=i+di[k];
                j0:=j+dj[k];
                if (i0>0) and (j0>0) and (i0<=n) and (j0<=n) then
                if (d[i0,j0]) and (a[i0,j0]<=right) and (a[i0,j0]>=left) then
                check(i0,j0);
        end;
end;

procedure process;
var     i,l,r,m:integer;
begin
        ans:=gmax-gmin;
        for i:=gmin to a[1,1] do
        begin
                l:=0;r:=ans;
                while l<>r do
                begin
                        m:=(l+r) div 2;
                        fillchar(d,sizeof(d),true);
                        left:=i;right:=i+m;
                        check(1,1);
                        if d[n,n]=false then r:=m else l:=m+1;
                end;
                ans:=l;
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


