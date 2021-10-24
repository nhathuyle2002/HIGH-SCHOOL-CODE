const   ginp='ss.inp';
        gout='ss.out';
        di:array[1..4] of longint =(-1,-1,1,1);
        dj:array[1..4] of longint =(-1,1,-1,1);

var     gi,go:text;
        n,m,p,q,s,t,r,l:longint;
        d:array[0..201,0..201] of boolean;
        f:array[0..201,0..201] of longint;
        qi,qj:array[0..40010] of longint;

procedure input;
var     i,ii,jj:longint;
begin
        fillchar(d,sizeof(d),true);
        readln(gi,n,m,p,q,s,t);
        for i:=1 to m do
        begin
                readln(gi,ii,jj);
                d[ii,jj]:=false;
        end;
end;

procedure push(i,j,gt:longint);
begin
        inc(r);
        qi[r]:=i;qj[r]:=j;
        f[i,j]:=gt;
end;

function cdt(i,j:longint):longint;
begin
        if (i<1) or (j<1) or (i>n) or (j>n) then exit(-1);
        if d[i,j]=false then exit(-1);
        if f[i,j]<>0 then exit(0);
        exit(1);
end;

procedure process;
var     u,v,u0,v0,i,k,tm:longint;
begin
        l:=0;r:=0;
        push(p,q,1);
        repeat
                inc(l);u:=qi[l];v:=qj[l];
                for k:=1 to 4 do
                begin
                        for i:=1 to n do
                        begin
                                u0:=u+i*di[k];
                                v0:=v+i*dj[k];
                                tm:=cdt(u0,v0);
                                if tm=-1 then break else
                                if tm=1 then push(u0,v0,f[u,v]+1);
                        end;
                end;
        until (l>=r) or (f[s,t]<>0);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        if f[s,t]<>0 then write(go,f[s,t]-1) else write(go,-1);
        close(gi);close(go);
end.
