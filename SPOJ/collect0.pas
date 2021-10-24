const   ginp='ss.inp';
        gout='ss.out';

type    tien=record z,s,m,sb:longint;end;

var     gi,go:text;
        f:array[0..5,0..5,0..5] of longint;
        d:array[0..5,0..5,0..5] of boolean;
        a:array[0..100000,1..2] of tien;
        q:array[0..100000] of tien;
        n,z0,s0,m0,dem,maxsb:longint;

procedure input;
var     j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,maxsb);
        readln(gi,q[1].z,q[1].s,q[1].m,z0,s0,m0);
        n:=0;
        while not eof(gi) do
        begin
                inc(n);
                for j:=1 to 2 do read(gi,a[n,j].z,a[n,j].s,a[n,j].m);
                readln(gi);
        end;
end;

procedure process;
var     i,j,k,t,j2,k2,t2,l,r:longint;
begin
        dem:=0;
        fillchar(d,sizeof(d),true);
        f[q[1].z,q[1].s,q[1].m]:=0;
        d[q[1].z,q[1].s,q[1].m]:=false;
        l:=0;r:=1;
        repeat
                inc(l);
                j:=q[l].z;k:=q[l].s;t:=q[l].m;
                if f[j,k,t]>maxsb then exit;
                if not ((j>=z0) and (k>=s0) and (t>=m0)) then
                for i:=1 to n do
                begin
                        j2:=j-a[i,1].z+a[i,2].z;
                        k2:=k-a[i,1].s+a[i,2].s;
                        t2:=t-a[i,1].m+a[i,2].m;
                        if (j>=a[i,1].z) and (k>=a[i,1].s) and (t>=a[i,1].m)
                        and (j2<=4) and (k2<=4) and (t2<=4) then
                        if d[j2,k2,t2] then
                        begin
                                f[j2,k2,t2]:=f[j,k,t]+1;
                                d[j2,k2,t2]:=false;
                                inc(r);
                                q[r].z:=j2;q[r].s:=k2;q[r].m:=t2;
                        end;
                end;
        until l>=r;
end;

procedure output;
var     j,k,t:longint;
begin
        for j:=z0 to 4 do
                for k:=s0 to 4 do
                        for t:=m0 to 4 do
                        if d[j,k,t]=false then inc(dem);
        if dem=0 then write(go,-1) else
        begin
                writeln(go,dem);
                for j:=z0 to 4 do
                        for k:=s0 to 4 do
                                for t:=m0 to 4 do
                                if d[j,k,t]=false then writeln(go,j,' ',k,' ',t,' ',f[j,k,t]);
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.














