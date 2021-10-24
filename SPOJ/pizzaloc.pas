const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,k,r,cou,res:longint;
        d:array[0..20,0..101] of longint;
        dd:array[0..101] of boolean;
        c:array[0..101] of longint;

procedure input;
var     i,xx,yy,j:longint;
        x,y:array[0..20] of longint;
begin
        readln(gi,k,r);
        readln(gi,m);
        for i:=1 to m do readln(gi,x[i],y[i]);
        readln(gi,n);
        for j:=1 to n do
        begin
                readln(gi,xx,yy,c[j]);
                for i:=1 to m do
                        if sqrt(sqr(xx-x[i])+sqr(yy-y[i]))<=r then
                        begin
                                inc(d[i,0]);
                                d[i,d[i,0]]:=j;
                        end;
        end;
end;

procedure try(tt,u:longint);
var     v,i:longint;
        ok:array[0..101] of boolean;
begin
        if tt=k+1 then
        begin
                if cou>res then res:=cou;
                exit;
        end;
        if m-u<k-tt+1 then exit;
        for v:=u+1 to m do
        begin
                for i:=1 to d[v,0] do
                        if dd[d[v,i]] then ok[i]:=false else
                        begin
                                dd[d[v,i]]:=true;
                                cou:=cou+c[d[v,i]];
                                ok[i]:=true;
                        end;
                try(tt+1,v);
                for i:=1 to d[v,0] do
                        if ok[i] then
                        begin
                                dd[d[v,i]]:=false;
                                cou:=cou-c[d[v,i]];
                        end;
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        fillchar(dd,sizeof(dd),false);
        cou:=0;res:=0;
        try(1,0);
        write(go,res);
        close(gi);close(go);
end.
