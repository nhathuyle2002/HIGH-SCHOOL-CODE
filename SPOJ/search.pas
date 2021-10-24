const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n,p,r,ans,dem:longint;
        a,b,c,sta:array[0..100010] of longint;
        d1,d2,d3:array[0..100010] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n,p);
        fillchar(d1,sizeof(d1),false);
        fillchar(d2,sizeof(d2),false);
        dem:=0;
        for i:=1 to m do
        begin
                read(gi,a[i]);
                if d1[a[i]]=false then
                begin
                        d1[a[i]]:=true;
                        inc(dem);
                end;
        end;
        readln(gi);
        for i:=1 to n do
        begin
                read(gi,b[i]);
                d2[b[i]]:=true;
        end;
        readln(gi);
        for i:=1 to p do read(gi,c[i]);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,ti,j:longint;
begin
        r:=0;ans:=0;ti:=0;
        fillchar(d3,sizeof(d3),true);
        for i:=1 to p do
        begin
                if d2[c[i]] then
                begin
                        for j:=r downto 1 do d3[sta[j]]:=true;
                        r:=0;
                        ti:=i;
                end;
                if (d1[c[i]]) and (d3[c[i]]) then
                begin
                        inc(r);
                        sta[r]:=c[i];
                        d3[c[i]]:=false;
                end;
                if r=dem then ans:=max(ans,i-ti);
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
